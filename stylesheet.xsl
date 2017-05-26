<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:wkdoc="http://www.wkpublisher.com/xml-namespaces/document">

    <xsl:variable name="list-step" select="4" />
    <xsl:variable name="list-unit" select="'em'" />
    <xsl:variable name="list-item-interval" select="-0" />
    <xsl:variable name="list-item-interval-unit" select="'em'" />
    <xsl:template match="/">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="A4" page-width="500mm" page-height="250mm">
                    <fo:region-body />
                </fo:simple-page-master>
            </fo:layout-master-set>

            <fo:page-sequence master-reference="A4">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block margin="0px 10px 10px 1px" color="#333333">
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:flow> 
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template match="h1">
        <fo:block font-weight="bold" font-size="13px" padding="10px 0px  0px 0px" margin="0px">
            <xsl:apply-templates />
        </fo:block>
    </xsl:template> 

    <xsl:template match="heading">
        <fo:block font-weight="bold" font-size="13px" padding="10px 0px  0px 0px" margin="0px 0px 20px 0px">
            <xsl:apply-templates />
        </fo:block>
    </xsl:template> 

    <xsl:template match="//bold">
        <fo:inline font-weight="bold">
            <xsl:apply-templates />
        </fo:inline> 
    </xsl:template>

    <xsl:template match="//italic">
        <fo:inline font-style="italic">
            <xsl:apply-templates />
        </fo:inline> 
    </xsl:template>

    <xsl:template match="//note">
        <fo:block border="1px solid #7f7d7f" background-color="#f9f7f9" padding-left="5px" margin="8px 0px 5px 0px">
            <xsl:apply-templates />
        </fo:block>
    </xsl:template>

    <xsl:template match="unordered-list | block-quote">
        <fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="break">
        <fo:inline>
            <br/>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>

    <xsl:template match="//wkdoc:level">
        <fo:block>
            <xsl:apply-templates />
        </fo:block>
    </xsl:template>

    <xsl:template match="//unordered-list">
        <xsl:apply-templates />
     </xsl:template>

    <xsl:template match="//list-item">
        <fo:block margin-left="11mm">
            <xsl:apply-templates />
        </fo:block>
    </xsl:template>

    <xsl:template match="//xhtml:table">
        <xsl:if test="normalize-space(@width)='' ">
            <fo:table table-layout="auto" margin="0px" padding-left="0px" border-collapse="collapse"> 
                <fo:table-column column-width="20%"/>
                <fo:table-column column-width="80%"/>           
                <fo:table-body>
                    <xsl:apply-templates />
                </fo:table-body>
            </fo:table>
        </xsl:if>
        <xsl:if test="normalize-space(@width)!='' ">
            <fo:table table-layout="fixed" width="{@width}"  margin="0px" padding-left="0px">
                <fo:table-body>
                    <xsl:apply-templates />
                </fo:table-body> 
            </fo:table> 
        </xsl:if>
    </xsl:template>

    <xsl:template match="//xhtml:tr">
        <fo:table-row padding="0px" margin-left="0px" >
            <xsl:apply-templates />
        </fo:table-row>
    </xsl:template>

    <xsl:template match="//xhtml:td">
        <fo:table-cell padding="0px" padding-left="0px"  margin-left="0px">
            <fo:block padding="3px" font-size="10.5px"  margin-left="0px">
                <xsl:apply-templates />
            </fo:block>
        </fo:table-cell>
    </xsl:template>

    <xsl:template match="//wkdoc:level/para[string(.)]">
        <xsl:if test="normalize-space(.)!='' ">
            <fo:block margin="10px 10px 10px 2px" font-size="11px">
                <xsl:apply-templates />
            </fo:block>
        </xsl:if>
    </xsl:template>

     <xsl:template match="//note/para">
            <fo:block margin="12px" margin-left="0px"> 
                <xsl:apply-templates />
            </fo:block>
    </xsl:template>

    <xsl:template match="//xhtml:td/para">
            <fo:block margin="0px 0px 0px 3px"> 
                <xsl:apply-templates />
            </fo:block>
    </xsl:template>

     <xsl:template match="//list-item/para[string(.)]">
        <xsl:if test="normalize-space(.)!='' " >
            <fo:block margin="10px" margin-left="0px" font-size="11px"> 
                <xsl:apply-templates />
            </fo:block>
        </xsl:if>
    </xsl:template>

    <xsl:template match="//footnote">
        <fo:basic-link external-destination="url({@id})" color="blue" text-decoration="underline">
           <fo:inline baseline-shift="super" font-size="80%">
            <xsl:value-of select="@num"/>          
           </fo:inline>
        </fo:basic-link>
    </xsl:template>

    <xsl:template match="//cite-ref">
        <xsl:variable name="href" select="concat('http:&#47;&#47;google.com&#47;?q=',@search-value)" />
		<fo:basic-link external-destination="{$href}" color="#0b61a8" font-weight="bold"  text-decoration="none">
			<xsl:value-of select="." />
		</fo:basic-link>
    </xsl:template>

    <xsl:template match="unordered-list" name="unordered-list">
        <xsl:param name="indent" />
        <xsl:variable name="current-indent">
            <xsl:choose>
                <xsl:when test="not($indent)">
                    <xsl:value-of select="$list-step" /></xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$indent" /></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <fo:list-block start-indent="{concat($current-indent,$list-unit)}" space-before="{concat($list-item-interval,$list-item-interval-unit)}" space-after="{concat($list-item-interval,$list-item-interval-unit)}">
            <xsl:for-each select="list-item|unordered-list">
                <xsl:choose>
                    <xsl:when test="self::list-item">
                        <xsl:call-template name="list-item">
                            <xsl:with-param name="indent" select="$current-indent" />
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise></xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="list-item" name="list-item">
        <xsl:param name="indent" />
        <xsl:variable name="current-indent">
            <xsl:choose>
                <xsl:when test="not($indent)">
                    <xsl:value-of select="$list-step" /></xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$indent" /></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="next-indent" select="$current-indent + $list-step" />
        <fo:list-item space-before="{concat($list-item-interval,$list-item-interval-unit)}" space-after="{concat($list-item-interval,$list-item-interval-unit)}" margin-left="30px">
            <fo:list-item-label>
                <fo:block></fo:block>
            </fo:list-item-label>
            <fo:list-item-body>
                <xsl:apply-templates select="node() except unordered-list" />
                <xsl:for-each select="unordered-list">
                    <xsl:call-template name="unordered-list">
                        <xsl:with-param name="indent " select="$next-indent" />
                    </xsl:call-template>
                </xsl:for-each>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
</xsl:stylesheet>