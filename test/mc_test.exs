defmodule SMPPEX.MCTest do
  use ExUnit.Case

  alias SMPPEX.MC

  test "start" do
    {:ok, pid} = Agent.start_link(fn -> [] end)
    handler = fn {:init, _socket, _transport}, st -> {:ok, st} end

    assert {:ok, _} = MC.start({Support.Session, {pid, handler}}, transport_opts: [port: 0])
  end

  test "stop" do
    {:ok, pid} = Agent.start_link(fn -> [] end)
    handler = fn {:init, _socket, _transport}, st -> {:ok, st} end

    assert {:ok, mc_server} =
             MC.start({Support.Session, {pid, handler}}, transport_opts: [port: 0])

    assert :ok == MC.stop(mc_server)
  end
end
