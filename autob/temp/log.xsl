<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xalan="http://xml.apache.org/xalan">
                
  <xsl:output method="xml" 
              encoding="UTF-8"
              indent="yes" 
              xalan:indent-amount="2"/>
<!--
   Licensed to the Apache Software Foundation (ASF) under one or more
   contributor license agreements.  See the NOTICE file distributed with
   this work for additional information regarding copyright ownership.
   The ASF licenses this file to You under the Apache License, Version 2.0
   (the "License"); you may not use this file except in compliance with
   the License.  You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
   
-->
 
<!--

  The purpose have this XSL is to provide a nice way to look at the output
  from the Ant XmlLogger (ie: ant -listener org.apache.tools.ant.XmlLogger )
  
  @author <a href="mailto:sbailliez@apache.org">Stephane Bailliez</a>
  
-->
<xsl:decimal-format decimal-separator="." grouping-separator="," />

<xsl:template match="/">
<html>
  <output>
    <!-- jakarta logo -->
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
      <td valign="top" class="bannercell">
		<h3>Output</h3>
      </td>
    </tr>
    </table>
    <xsl:apply-templates select="build"/>
  </output>
</html>
</xsl:template>

<xsl:template match="build">
  <!-- build status -->
  <!--<table width="100%">-->
    <xsl:attribute name="class">
      <xsl:if test="@error">failed</xsl:if>
      <xsl:if test="not(@error)">complete</xsl:if>
    </xsl:attribute>
    <!--<tr>-->
      <xsl:if test="@error">
        <!--<td nowrap="yes">-->Build Failed<!--</td> -->
      </xsl:if>
      <xsl:if test="not(@error)">
        <!--<td nowrap="yes">--><h3>Build Complete</h3><!--</td>-->
      </xsl:if>
		<p>Total Time: <xsl:value-of select="@time"/></p>
        <xsl:if test="@error">
          <tt><xsl:value-of select="@error"/></tt><br/>
          <i style="font-size:80%">See the <a href="#stacktrace" alt="Click for details">stacktrace</a>.</i>
        </xsl:if>
  <!-- build information -->
  <h3>Build events</h3>
  <table class="log" border="1" cellspacing="2" cellpadding="3" width="100%">
  <tr>
    <th nowrap="yes" align="left" width="1%">target</th>
    <th nowrap="yes" align="left" width="1%">task</th>
    <th nowrap="yes" align="left">message</th>
  </tr>
  <xsl:apply-templates select=".//message[@priority != 'debug']"/>
  </table>
  <p>
  <!-- stacktrace -->
  <xsl:if test="stacktrace">
  <a name="stacktrace"/>
  <h3>Error details</h3>
  <table width="100%">
    <tr><td>
      <pre><xsl:value-of select="stacktrace"/></pre>
    </td></tr>
  </table>
  </xsl:if>
  </p>
</xsl:template>

<!-- report every message but those with debug priority -->
<xsl:template match="message[@priority!='debug']">
  <tr valign="top">
    <!-- alternated row style -->
    <xsl:attribute name="class">
      <xsl:if test="position() mod 2 = 1">a</xsl:if>
      <xsl:if test="position() mod 2 = 0">b</xsl:if>
    </xsl:attribute>
    <td nowrap="yes" width="1%"><xsl:value-of select="../../@name"/></td>
    <td nowrap="yes" style="text-align:right" width="1%">[ <xsl:value-of select="../@name"/> ]</td>
    <td class="{@priority}" nowrap="yes">
            <xsl:value-of select="text()"/>
    </td>
  </tr>
</xsl:template>

</xsl:stylesheet>
