ExUnit.start()
Mox.defmock(DbServiceMock, for: DbService)
Mox.defmock(InventoryConsumerMock, for: InventoryConsumerBeh)
Mox.defmock(InventoryDbServiceMock, for: Ecto.Repo)
