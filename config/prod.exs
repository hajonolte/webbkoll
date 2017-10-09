use Mix.Config

# For production, we configure the host to read the PORT
# from the system environment. Therefore, you will need
# to set PORT=80 before running your server.
#
# You should also configure the url host to something
# meaningful, we use this information when generating URLs.
#
# Finally, we also include the path to a manifest
# containing the digested version of static files. This
# manifest is generated by the mix phoenix.digest task
# which you typically run after static files are built.
config :webbkoll, WebbkollWeb.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: "webbkoll.dataskydd.net", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true,
  version: Application.spec(:myapp, :vsn)

# Do not print debug messages in production
config :logger, level: :info

# ## SSL Support
#
# To get SSL working, you will need to add the `https` key
# to the previous section and set your `:url` port to 443:
#
#     config :webbkoll, WebbkollWeb.Endpoint,
#       ...
#       url: [host: "example.com", port: 443],
#       https: [port: 443,
#               keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#               certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables return an absolute path to
# the key and cert in disk or a relative path inside priv,
# for example "priv/ssl/server.key".
#
# We also recommend setting `force_ssl`, ensuring no data is
# ever sent via http, always redirecting to https:
#
#     config :webbkoll, WebbkollWeb.Endpoint,
#       force_ssl: [hsts: true]
#
# Check `Plug.SSL` for all available options in `force_ssl`.

# ## Using releases
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start the server for all endpoints:
#
#     config :phoenix, :serve_endpoints, true
#
# Alternatively, you can configure exactly which server to
# start per endpoint:
#
#     config :webbkoll, WebbkollWeb.Endpoint, server: true
#
# You will also need to set the application root to `.` in order
# for the new static assets to be served after a hot upgrade:
#
#     config :webbkoll, WebbkollWeb.Endpoint, root: "."

# Finally import the config/prod.secret.exs
# which should be versioned separately.
#import_config "prod.secret.exs"

config :webbkoll,
  backends: [
    {Webbkoll.Queue.Q1, %{concurrency: 7, logger_tag: "queue 1", url: "http://localhost:8100/"}},
  ],
  max_attempts: 2,
  locales: ~w(en sv),
  default_locale: "en",
  # validate_urls: If true, only check URLs with a valid domain name
  # (i.e. ones with a TLD in the Public Suffix List),
  # and only the standard HTTP/HTTPS ports.
  validate_urls: true,
  # rate_limit_client: An IP address can make <limit> new site checks during <scale> milliseconds.
  # rate_limit_host: The tool will query a specific host no more than <limit> times during <scale> milliseconds.
  # See https://github.com/grempe/ex_rated
  rate_limit_client: %{"scale" => 60_000, "limit" => 20},
  rate_limit_host: %{"scale" => 60_000, "limit" => 5}
