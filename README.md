# Foobara::EmptyRubyProjectGenerator

Generates an empty Ruby project with rubocop, rspec, and GitHub Actions 
already wired up, so you can focus on writing your gem's code rather than 
setting up boilerplate code.

## Installation

Install the gem directly in the terminal:

    $ gem install foobara-empty-ruby-project-generator

Or add it to your Gemfile:

    $ bundle add foobara-empty-ruby-project-generator

You will also need the `foob` CLI to run the generator:

    $ gem install foob

## Usage

Run the generator to create a new project:

    $ foob g ruby-project -n NAME [options]

The `-n` flag represents the name of the project to be generated and is required. It accepts either a plain project name or a name in the 
`org/project` format:

- **Individual account:** `-n my-gem` — creates a project with a single 
  module e.g. `MyGem`
- **Organization:** `-n my-org/my-gem` — creates a project with a nested 
  module e.g. `MyOrg::MyGem` and uses `my-org` as the GitHub organization

For a full list of available options run:

    $ foob g ruby-project --help

**Commonly used options:**

| Flag | Description |
|------|-------------|
| `-n, --name` | Project name or org/project (required) |
| `-d, --description` | Project description. Defaults to `"No description. Add one."` |
| `-a, --author-names` | Author name(s) |
| `--author-emails` | Author email(s) |
| `-l, --license` | One of: `MIT`, `Apache-2.0`, `MPL-2.0`, `Apache-2.0 OR MIT` |
| `-u, --use-git` | Initialize a git repository |
| `--push-to-github` | Create a private GitHub repo and push to it |
| `-o, --output-directory` | Where to generate the project. Defaults to the project name |

**Example:**

    $ foob g ruby-project -n my-org/my-gem -d "Does something useful" -l MIT --use-git

Once generated, your project will have a `lib/` folder which is where 
your gem's Ruby code lives. Based on the name you provided when generating the project, the lib folder will be 
structured as:

- `lib/my_org/my_gem.rb` for an org/project name
- `lib/my_gem.rb` for a plain project name

Within the generated `.rb` file located in the `lib/` folder, you can place your gem's Ruby code. 

## Contributing

Contributions in the form of PRs and issues are always welcome.

To work on an existing issue or submit a PR:

1. Fork the repo and clone it to your local machine
2. Run `bundle install` to install dependencies
3. Implement your changes and add tests where applicable
4. Run `rake` to ensure all tests pass and that rubocop reports no errors
5. Commit, push to GitHub and open a PR for review

## License

This project is licensed under your choice of the Apache-2.0 license or 
the MIT license. See [LICENSE.txt](LICENSE.txt) for more info.