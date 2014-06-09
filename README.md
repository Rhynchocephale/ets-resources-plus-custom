## OGC Test Suite Resources

This project assembles all libraries required by OGC conformance test suites 
into a single archive for distribution. The contents of the resulting archive 
are summarized below.

<table style="text-align:left">
  <tr>
    <th>Archive Entry</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>config.xml</td>
    <td>A TEAM-engine configuration file (TE_BASE/config.xml) that specifies 
    settings for the latest test suite releases.</td>
  </tr>
  <tr>
    <td>config-approved.xml</td>
    <td>A configuration file that only includes test suites that have been 
    formally approved by the OGC Technical Committee.</td>
  </tr>
  <tr>
    <td>ctl-scripts-release.csv</td>
    <td>A CSV file that supplies the repository locations of the CTL scripts 
    corresponding to the latest test suites.</td>
  </tr>
  <tr>
    <td>lib/</td>
    <td>A directory containing the required Java libraries; these must be available 
    on the class path.</td>
  </tr>
</table>

Note that when building the [teamengine-web application](https://github.com/opengeospatial/teamengine), 
if the 'ogc.cite' profile is active then all test suite dependencies are incorporated within 
the WAR file. The 'ets-resources-version' property must be set in ${user.home}/.m2/settings.xml 
as shown below, where `YY.MM.DD` denotes the desired release version.

    <profile>
      <id>ogc.cite</id>
      <activation>
        <activeByDefault>true</activeByDefault>
      </activation>
      <properties>
        <ets-resources-version>YY.MM.DD</ets-resources-version>
      </properties>
      <repositories>
        <repository>
          <id>opengeospatial-cite</id>
          <name>OGC CITE Repository</name>
          <url>https://svn.opengeospatial.org/ogc-projects/cite/maven</url>
          <snapshots>
            <enabled>false</enabled>
          </snapshots>
        </repository>
      </repositories>
    </profile>
