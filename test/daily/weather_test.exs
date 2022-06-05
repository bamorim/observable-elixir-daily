defmodule Daily.WeatherTest do
  use Daily.DataCase

  describe "get_current_weather/0" do
    setup :mock_weather_api

    test "it returns the current weather" do
      assert %{weather: "rainy"} = Daily.Weather.get_current_weather()
    end

    @tag weather: "sunny"
    test "it returns the another weather" do
      assert %{weather: "sunny"} = Daily.Weather.get_current_weather()
    end
  end
end
