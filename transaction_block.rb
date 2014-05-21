def within_transaction
  begin
    puts "begin transaction"
    yield
    puts "commit"
  rescue => e
    puts "rollback"
    raise e
  end
end

within_transaction do
  raise "some error"
end
