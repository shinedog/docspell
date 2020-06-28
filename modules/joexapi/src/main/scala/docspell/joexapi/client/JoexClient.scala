package docspell.joexapi.client

import scala.concurrent.ExecutionContext

import cats.effect._
import cats.implicits._

import docspell.common.syntax.all._
import docspell.common.{Ident, LenientUri}
import docspell.joexapi.model.BasicResult

import org.http4s.circe.CirceEntityDecoder._
import org.http4s.client.Client
import org.http4s.client.blaze.BlazeClientBuilder
import org.http4s.{Method, Request, Uri}
import org.log4s.getLogger

trait JoexClient[F[_]] {

  def notifyJoex(base: LenientUri): F[Unit]

  def notifyJoexIgnoreErrors(base: LenientUri): F[Unit]

  def cancelJob(base: LenientUri, job: Ident): F[BasicResult]

}

object JoexClient {

  private[this] val logger = getLogger

  def apply[F[_]: Sync](client: Client[F]): JoexClient[F] =
    new JoexClient[F] {
      def notifyJoex(base: LenientUri): F[Unit] = {
        val notifyUrl = base / "api" / "v1" / "notify"
        val req       = Request[F](Method.POST, uri(notifyUrl))
        logger.fdebug(s"Notify joex at ${notifyUrl.asString}") *>
          client.expect[String](req).map(_ => ())
      }

      def notifyJoexIgnoreErrors(base: LenientUri): F[Unit] =
        notifyJoex(base).attempt.map {
          case Right(()) => ()
          case Left(ex) =>
            logger.warn(
              s"Notifying Joex instance '${base.asString}' failed: ${ex.getMessage}"
            )
            ()
        }

      def cancelJob(base: LenientUri, job: Ident): F[BasicResult] = {
        val cancelUrl = base / "api" / "v1" / "job" / job.id / "cancel"
        val req       = Request[F](Method.POST, uri(cancelUrl))
        client.expect[BasicResult](req)
      }

      private def uri(u: LenientUri): Uri =
        Uri.unsafeFromString(u.asString)
    }

  def resource[F[_]: ConcurrentEffect](ec: ExecutionContext): Resource[F, JoexClient[F]] =
    BlazeClientBuilder[F](ec).resource.map(apply[F])
}
