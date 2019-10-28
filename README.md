# neo4j-driver-performance

### Setup

From root directory of this project
1. `bundle install`
2. make sure the neo4j server is running
3. update the config.rb with credentials of neo4j

### Usage

After following the Setup step, from the root directory of this project just run following command.

`ruby performance_script.rb`

Results will be printed on console as output

### Other Configs

#### Seabolt

To run with seabolt we need to set `SEABOLT_LIB` environment variable to have path of seabolt
e.g. `SEABOLT_LIB=~/seabolt/build/dist/lib/libseabolt17.dylib ruby performance_script.rb`

To run without seabolt we can set `SEABOLT_LIB` to null

#### Jruby / MRI

To run against different ruby, we need to manually change the ruby version using ruby version manger and then doing the bundle install before running the script again.
