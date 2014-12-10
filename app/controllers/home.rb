# require 'csv'
post '/' do
  unless file_uploaded?
    @error = "forgetting the file?"
    return erb :home
  end
  @filename = params[:file][:filename]
  unless valid_file_type?
    @error = "invalid file type - we need '.txt' or '.csv'"
    return erb :home
  end
  puts @content.read
  return erb :home
end

get '/' do
  erb :home
end

private

def file_uploaded?
  params[:file] && @content = params[:file][:tempfile]  
end

def valid_file_type?
  [".txt", ".csv"].include? File.extname(@filename)
end
