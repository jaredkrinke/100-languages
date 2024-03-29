<?xml-stylesheet type="text/xsl" href="p9.xsl"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- Above: use the stylesheet itself as input to make this self-contained -->

    <!-- Note: solved two equations on paper for a ("a^2 + b^2 = c^2" and "a + b + c = 1000") -->
    <!-- Solutions for a, given b: (1000000 - 2000 * b) / (2000 - 2 * b) -->
    <xsl:template name="find-a">
        <xsl:param name="b" select="1"/>
        <xsl:variable name="a" select="(1000000 - 2000 * $b) div (2000 - 2 * $b)"/>
        <xsl:choose>
            <!-- Check if integer result -->
            <xsl:when test="round($a) = $a">
                <!-- Compute a * b * c -->
                <xsl:variable name="c" select="1000 - $a - $b"/>
                <xsl:value-of select="$a * $b * $c"/>
            </xsl:when>
            <xsl:otherwise>
                <!-- Keep searching -->
                <xsl:call-template name="find-a">
                    <xsl:with-param name="b"><xsl:value-of select="$b + 1"/></xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Call recursive template defined above -->
    <xsl:template match="/">
        <xsl:call-template name="find-a"/>
    </xsl:template>
  </xsl:stylesheet>
