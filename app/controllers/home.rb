include FileParser
post '/' do
  validate_upload
  return erb :home if @error
  @menu_data = Parser.create_objects_from_file(MenuItem, @tempfile)
  validate_data
  return erb :home if @error
  combinator = Combinator.new(@menu_data)
  @time_to_solve = Benchmark.realtime {combinator.solve}
  @combos = combinator.combos
  p @combos
  return erb :home
end

get '/' do
  erb :home
end

private
def validate_upload
  return @error = "forgetting the file?" unless file_uploaded?
  @filename = params[:file][:filename]
  @error = "invalid file type - we need '.txt' or '.csv'" unless valid_file_type?
end

def file_uploaded?
   params[:file] && @tempfile = params[:file][:tempfile]
end

def valid_file_type?
  [".txt", ".csv"].include? File.extname(@filename)
end

def validate_data
  @error = @menu_data[:error] if @menu_data[:error]
end