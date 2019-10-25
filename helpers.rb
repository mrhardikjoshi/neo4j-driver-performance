def get_driver_object
  Neo4j::Driver::GraphDatabase.driver(BOLT_URI, Neo4j::Driver::AuthTokens.basic(USER, PASSWORD))
end

def print_benchmark_results(result, opts)
  puts "="*50
  puts "for loop_count #{opts[:loop_count]}"
  puts opts[:prefix_text]
  puts result.inspect
end

def delete_all_nodes
  driver = get_driver_object
  driver.session.run "MATCH (n) DETACH DELETE n;"
  driver.close
end

def write_multi_transaction(loop_count, driver=nil)
  query = "CREATE (a:Teacher) SET a.name = $name"
  hash_arg = { name: 'teacher' }
  driver = get_driver_object if driver.nil?
  result = nil

  driver.session do |session|
    result = Benchmark.measure do
      loop_count.times do |c|
        session.write_transaction do |tx|
          tx.run(query, hash_arg)
        end
      end
    end
  end
  driver.close
  print_benchmark_results(result, prefix_text: "While write_transaction multiple session", loop_count: loop_count)
end

def read_multi_transaction(loop_count, driver=nil)
  query = "MATCH (a:Teacher) RETURN a"
  driver = get_driver_object if driver.nil?
  result = nil

  driver.session do |session|
    result = Benchmark.measure do
      loop_count.times do |c|
        session.read_transaction do |tx|
          tx.run(query).each(&:itself)
        end
      end
    end
  end
  driver.close
  print_benchmark_results(result, prefix_text: "While read_transaction multiple session", loop_count: loop_count)
end

def write_single_transaction(loop_count, driver=nil)
  query = "CREATE (a:Teacher) SET a.name = $name"
  hash_arg = { name: 'teacher' }
  driver = get_driver_object if driver.nil?
  result = nil

  driver.session do |session|
    result = Benchmark.measure do
      session.write_transaction do |tx|
        loop_count.times do |c|
          tx.run(query, hash_arg)
        end
      end
    end
  end
  driver.close
  print_benchmark_results(result, prefix_text: "While write_transaction single session", loop_count: loop_count)
end

def read_single_transaction(loop_count, driver=nil)
  query = "MATCH (a:Teacher) RETURN a"
  driver = get_driver_object if driver.nil?
  result = nil

  driver.session do |session|
    result = Benchmark.measure do
      session.read_transaction do |tx|
        loop_count.times do |c|
          tx.run(query).each(&:itself)
        end
      end
    end
  end
  driver.close
  print_benchmark_results(result, prefix_text: "While read_transaction single session", loop_count: loop_count)
end
