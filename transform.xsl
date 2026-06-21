<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- Товары -->
    <xsl:key name="items-by-org-city" match="item" use="concat(@org, '|', @city)" />

    <!-- Компании -->
    <xsl:key name="orgs-by-city" match="item" use="@city" />

    <xsl:template match="/">
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                <title>Города</title>
            </head>
            <body>
                <h1>Города и компании</h1>
                <ul>
                    <!-- Проход по городам -->
                    <xsl:for-each select="orgs/item[generate-id() = generate-id(key('orgs-by-city', @city)[1])]">
                        <xsl:sort select="@city" />
                        <li>
                            <h3><xsl:value-of select="@city" /></h3>
                            
                            <!-- Товары в городе -->
                            <xsl:variable name="city-items" select="key('orgs-by-city', @city)" />
                            <p>Всего товаров: <xsl:value-of select="count($city-items)" /></p>
                            
                            <!-- Компании в городе -->
                            <ul>
                                <xsl:for-each select="$city-items[generate-id() = generate-id(key('items-by-org-city', concat(@org, '|', @city))[1])]">
                                    <xsl:sort select="@org" />
                                    <li>
                                        <h4><xsl:value-of select="@org" /></h4>
                                        
                                        <!-- Товары компании в городе -->
                                        <xsl:variable name="org-items" select="key('items-by-org-city', concat(@org, '|', @city))" />
                                        <p>Всего товаров: <xsl:value-of select="count($org-items)" /></p>
                                        
                                        <ul>
                                            <xsl:for-each select="$org-items">
                                                <xsl:sort select="@title" />
                                                <li><xsl:value-of select="@title" /></li>
                                            </xsl:for-each>
                                        </ul>
                                    </li>
                                </xsl:for-each>
                            </ul>
                        </li>
                    </xsl:for-each>
                </ul>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
