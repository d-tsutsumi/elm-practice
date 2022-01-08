module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (alt, class, placeholder, src, type_)
import List exposing (repeat)


view : Html msg
view =
    div []
        [ header
        , containerLayout
        ]


containerLayout : Html msg
containerLayout =
    div [ class "container-lg pt-3" ]
        [ div [ class "d-flex flex-wrap flex-content-start" ] (copyCard dogCard 5)
        ]


copyCard : Html msg -> Int -> List (Html msg)
copyCard card item =
    repeat item card


dogCard : Html msg
dogCard =
    div [ class "Box color-shadow-small flex-equal m-2" ]
        [ div [ class "Box-row" ]
            [ img
                [ class "img-responsive dog-image"
                , src "./../public/pexels-christian-domingues-731022.jpg"
                , alt "dog"
                ]
                []
            ]
        , div [ class "Box-row" ]
            [ p [ class "mb-0 color-fg-muted" ]
                [ text """
                text text text
                text text text
                text text text
                text text text
                text text text
                text text text
              """
                ]
            ]
        , div [ class "Box-row" ]
            [ button
                [ type_ "button"
                , class "btn btn-primary btn-block"
                ]
                [ text "detail dog" ]
            ]
        ]


header : Html msg
header =
    div [ class "Header" ]
        [ div [ class "Header-item" ] [ text "Search Dog" ]
        , div [ class "Header-item" ]
            [ input
                [ type_ "text"
                , placeholder "SearchDog"
                , class "form-control Header-input"
                ]
                []
            ]
        ]


main : Html msg
main =
    view
