defmodule DbService do
  alias OrderProducer.Order
  alias OrderProducer.Repo

  @doc"""
  stores order details in db
  returns: {:ok, order_struct} or {:error, changeset}
  """
  def store_order(order) do
    %Order{}
    |> Order.changeset(order)
    |> Repo.insert()
  end
end
