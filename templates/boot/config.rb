require "foobara/load_dotenv"

Foobara::LoadDotenv.run!(env: ENV.fetch("FOOBARA_ENV"))
