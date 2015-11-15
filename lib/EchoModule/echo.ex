defmodule Echo do
  use Servus.Module 
  require Logger

  register "echo"

  def startup do
    Logger.debug "Echo module registered"
    [] # Return aodule state here
  end

  handle "echo", args, state do
    Logger.debug "Echo module called"
    args
  end
end