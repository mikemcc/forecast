describe "hello world", js:true do 
  it 'will use the default js driver'
  it 'will switch to one specific driver', :driver => :webkit
end
