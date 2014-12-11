include FileParser
require 'pry'
require 'benchmark'
post '/' do

  validate_upload
  return erb :home if @error
  if @extname == ".csv"
    @menu_data = CSVParser.create_objects_from_file(MenuItem, @filename)
    combinator = Combinator.new(@menu_data)
    @time_to_solve = Benchmark.realtime {combinator.solve}
    @combos = combinator.combos
  elsif extname == ".txt"
  end

  return erb :home
end


get '/' do
  erb :home
end

private

def validate_upload
  unless file_uploaded?
    @error = "forgetting the file?" 
    return
  end
  @error = "invalid file type - we need '.txt' or '.csv'" unless valid_file_type?
end

def file_uploaded?
   params[:file] && (@content = params[:file][:tempfile])
end

def valid_file_type?
  @filename = params[:file][:filename]
  @extname = File.extname(@filename)
  [".txt", ".csv"].include? @extname
end
