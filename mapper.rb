require 'writeexcel'
require 'json'

class Mapper
  attr_accessor :data
  def generate
    self.instance_eval File.read 'Mapping'
  end
  def workbook(filename)
    @workbook = WriteExcel.new filename
    yield
    @workbook.close
  end
  def sheet(sheetname)
    @sheet = @workbook.add_worksheet sheetname
    @rownum = 0
    yield @sheet
  end
  def cell(label, fieldname=nil)
    value = @data[fieldname.to_s] if fieldname
    value = yield if block_given?

    @sheet.write @rownum, 0, label
    @sheet.write @rownum, 1, value
    @rownum = @rownum + 1
  end
end
m = Mapper.new
m.data = JSON.parse File.read 'data.json'
m.generate
