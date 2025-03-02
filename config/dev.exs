import Config

config :bella, Bella.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "bella_dev",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
