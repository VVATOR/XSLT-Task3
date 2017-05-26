#rem test only my variant task (Vitali Vikhliayeu – test3.xml)
java -jar saxon9he.jar -s:input.xml -xsl:stylesheet.xsl -o:output.fo
fop -fo output.fo -pdf TASK_3.pdf