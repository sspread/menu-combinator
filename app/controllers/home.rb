include FileParser

post '/' do

  validate_upload
  extname = File.extname(@filename)
  if extname == ".csv"
    menu_data = CSVParser.create_objects_from_file(MenuItem, @filename)
    Combinator.new(menu_data)
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
    return erb :home
  end
  @filename = params[:file][:filename]
  unless valid_file_type?
    @error = "invalid file type - we need '.txt' or '.csv'"
    return erb :home
  end
end

def file_uploaded?
  params[:file] && @content = params[:file][:tempfile]  
end

def valid_file_type?
  [".txt", ".csv"].include? File.extname(@filename)
end
