module NewGameHelpers
  def start_new_game
    steps %{
      When I run `forca` interactively
    }
  end
end

World(NewGameHelpers)
