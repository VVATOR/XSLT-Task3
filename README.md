# XSLT-Task3
<details>
  <summary>XSLT-Task3 description</summary>

  Задание 3:
  
  Трансформировать XML-документ в PDF-документ, максимально похожий на страницу, представленную на скриншоте.
  
  https://github.com/VVATOR/XSLT-Task3/blob/master/task2.png

</details>



## Generate PDF

### Two steps for generating PDF:

 - SaxonHE9-7-0-18J  transform ***xsl+xml*** to **output.fo**
```
  java -jar saxon9he.jar -s:input.xml -xsl:stylesheet.xsl -o:output.fo
```
  
 - Apache Fop 2.2  transform ***output.fo*** to ***pdf***
```
  fop -fo output.fo -pdf TASK_3.pdf
```


### OR
Use file ***transform.bat***