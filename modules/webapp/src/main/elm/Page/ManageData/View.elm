module Page.ManageData.View exposing (view)

import Comp.EquipmentManage
import Comp.OrgManage
import Comp.PersonManage
import Comp.TagManage
import Data.UiSettings exposing (UiSettings)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Page.ManageData.Data exposing (..)
import Util.Html exposing (classActive)


view : UiSettings -> Model -> Html Msg
view settings model =
    div [ class "managedata-page ui padded grid" ]
        [ div [ class "sixteen wide mobile four wide tablet four wide computer column" ]
            [ h4 [ class "ui top attached ablue-comp header" ]
                [ text "Manage Data"
                ]
            , div [ class "ui attached fluid segment" ]
                [ div [ class "ui fluid vertical secondary menu" ]
                    [ div
                        [ classActive (model.currentTab == Just TagTab) "link icon item"
                        , onClick (SetTab TagTab)
                        ]
                        [ i [ class "tag icon" ] []
                        , text "Tag"
                        ]
                    , div
                        [ classActive (model.currentTab == Just EquipTab) "link icon item"
                        , onClick (SetTab EquipTab)
                        ]
                        [ i [ class "box icon" ] []
                        , text "Equipment"
                        ]
                    , div
                        [ classActive (model.currentTab == Just OrgTab) "link icon item"
                        , onClick (SetTab OrgTab)
                        ]
                        [ i [ class "factory icon" ] []
                        , text "Organization"
                        ]
                    , div
                        [ classActive (model.currentTab == Just PersonTab) "link icon item"
                        , onClick (SetTab PersonTab)
                        ]
                        [ i [ class "user icon" ] []
                        , text "Person"
                        ]
                    ]
                ]
            ]
        , div [ class "sixteen wide mobile twelve wide tablet twelve wide computer column" ]
            [ div [ class "" ]
                (case model.currentTab of
                    Just TagTab ->
                        viewTags model

                    Just EquipTab ->
                        viewEquip model

                    Just OrgTab ->
                        viewOrg settings model

                    Just PersonTab ->
                        viewPerson settings model

                    Nothing ->
                        []
                )
            ]
        ]


viewTags : Model -> List (Html Msg)
viewTags model =
    [ h2 [ class "ui header" ]
        [ i [ class "ui tag icon" ] []
        , div [ class "content" ]
            [ text "Tags"
            ]
        ]
    , Html.map TagManageMsg (Comp.TagManage.view model.tagManageModel)
    ]


viewEquip : Model -> List (Html Msg)
viewEquip model =
    [ h2 [ class "ui header" ]
        [ i [ class "ui box icon" ] []
        , div [ class "content" ]
            [ text "Equipment"
            ]
        ]
    , Html.map EquipManageMsg (Comp.EquipmentManage.view model.equipManageModel)
    ]


viewOrg : UiSettings -> Model -> List (Html Msg)
viewOrg settings model =
    [ h2 [ class "ui header" ]
        [ i [ class "ui factory icon" ] []
        , div [ class "content" ]
            [ text "Organizations"
            ]
        ]
    , Html.map OrgManageMsg (Comp.OrgManage.view settings model.orgManageModel)
    ]


viewPerson : UiSettings -> Model -> List (Html Msg)
viewPerson settings model =
    [ h2 [ class "ui header" ]
        [ i [ class "ui user icon" ] []
        , div [ class "content" ]
            [ text "Person"
            ]
        ]
    , Html.map PersonManageMsg (Comp.PersonManage.view settings model.personManageModel)
    ]
