module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (alt, class, placeholder, src, type_)
import Http
import Json.Decode exposing (Decoder, list, string, succeed)
import Json.Decode.Pipeline exposing (required)
import List exposing (repeat)


initialModel : Model
initialModel =
    { dogImage = Nothing
    }


type alias DogImage =
    { message : List String
    , status : String
    }


type Msg
    = LoadImage (Result Http.Error DogImage)


type alias Model =
    { dogImage : Maybe DogImage
    }


init : () -> ( Model, Cmd Msg )
init () =
    ( initialModel, fetchLoadImage )


decodeDogImage : Decoder DogImage
decodeDogImage =
    succeed DogImage
        |> required "message" (list string)
        |> required "status" string


baseURL : Int -> String
baseURL dogNum =
    "https://dog.ceo/api/breeds/image/random/" ++ String.fromInt dogNum



-- Update


fetchLoadImage : Cmd Msg
fetchLoadImage =
    Http.get
        { url = baseURL 5
        , expect = Http.expectJson LoadImage decodeDogImage
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadImage (Ok dogImage) ->
            ( { model | dogImage = Just dogImage }
            , Cmd.none
            )

        LoadImage (Err _) ->
            ( model, Cmd.none )



-- View


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


view : Model -> Html msg
view model =
    div []
        [ header
        , containerLayout
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
