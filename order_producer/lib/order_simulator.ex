defmodule OrderSimulator do
  # Fetches product list from the database
  def get_products do
    OrderProducer.Product
    |> OrderProducer.Repo.all()
    |> Enum.map(fn product ->
      %{
        id: product.id,
        name: product.name,
        description: product.description,
        price: product.price
      }
    end)
  end

  # Generates a fake order
  def generate_order do
    list_products = get_products()
    product = Enum.random(list_products)  # Select a single random product
    order_date = DateTime.utc_now()

    %{
      order_date: order_date,
      product_id: product.id,
      quantity: random_quantity()
    }
  end

  # Returns a random quantity between 1 and 4
  defp random_quantity do
    :rand.uniform(4)
  end
end
