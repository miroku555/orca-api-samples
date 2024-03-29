require 'pp'
require 'crack' # for xml and json
require 'crack/xml' # for just xml

XML = <<EOF
<hoge>
  <moge attr1="array">
    <moge_child attr2="foo">
	  <name attr3="string">foo</name>
	</moge_child>
    <moge_child attr2="bar">
	  <name attr3="string">bar</name>
	</moge_child>
  </moge>
</hoge>
EOF

root = Crack::XML.parse(XML)
#{"hoge"=>{"moge"=>[{"name"=>"foo"}, {"name"=>"bar"}]}}
pp root

puts"======================"

XML2 = <<EOF
<hoge>
  <moge attr1="array" attr2="white"/>
</hoge>
EOF
root = Crack::XML.parse(XML2)
pp root

puts "============"
root = Crack::XML.parse(File.read("patient.xml"))
result = root["xmlio2"]["patientlst1res"]["Api_Result"]
unless result == "00"
  puts "error:#{result}"
  exit 1
end
pinfo = root["xmlio2"]["patientlst1res"]["Patient_Information"]
pinfo.each do |patient|
  puts patient["WholeName"]
end
