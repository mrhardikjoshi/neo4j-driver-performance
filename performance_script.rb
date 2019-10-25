# require 'neo4j-java-driver'
require 'neo4j_ruby_driver'
require 'benchmark'
require 'pry'
require './config'
require './helpers'

puts "neo4j-driver version: #{Neo4j::Driver::VERSION}"
puts "Ruby version: #{RUBY_VERSION}"
puts "ENV['SEABOLT_LIB'].size = #{ENV['SEABOLT_LIB'].size}"

# for 10_000 records write and read (read 1k time looped)
delete_all_nodes
write_multi_transaction(10_000)
delete_all_nodes
write_multi_transaction(10_000)
delete_all_nodes
write_multi_transaction(10_000)
read_multi_transaction(5)
read_multi_transaction(5)
read_multi_transaction(5)
delete_all_nodes
write_single_transaction(10_000)
delete_all_nodes
write_single_transaction(10_000)
delete_all_nodes
write_single_transaction(10_000)
read_single_transaction(5)
read_single_transaction(5)
read_single_transaction(5)
delete_all_nodes

# for 50_000 records write and read (read 1k time looped)
write_multi_transaction(50_000)
delete_all_nodes
write_multi_transaction(50_000)
delete_all_nodes
write_multi_transaction(50_000)
read_multi_transaction(5)
read_multi_transaction(5)
read_multi_transaction(5)
delete_all_nodes
write_single_transaction(50_000)
delete_all_nodes
write_single_transaction(50_000)
delete_all_nodes
write_single_transaction(50_000)
read_single_transaction(5)
read_single_transaction(5)
read_single_transaction(5)
delete_all_nodes
