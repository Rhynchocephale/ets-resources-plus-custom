## OGC Test Suite Resources

This project assembles all libraries required by OGC conformance test suites 
into a single archive for distribution. The contents of the resulting archive 
are summarized below.

<table style="text-align: left;">
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
    <td>A configuration file that includes only test suite releases that have 
    been formally approved for compliance certification by the OGC Technical 
    Committee.</td>
  </tr>
  <tr>
    <td style="vertical-align: top">ctl-scripts-release.csv</td>
    <td>A CSV file that supplies the Git repository URL and tag name for the 
    latest test suite releases. Each line contains two fields as shown below.
      <pre>https://github.com/opengeospatial/ets-kml22.git,2.2-r11</pre>
    </td>
  </tr>
  <tr>
    <td>lib/</td>
    <td>A directory containing the required Java libraries; these must be 
    available on the class path.</td>
  </tr>
  <tr>
    <td style="vertical-align: top">bin/</td>
    <td>A directory containing shell scripts for Windows- and UNIX-based 
    (Linux/Mac) hosts:
    <ul>
      <li><code>setup-tebase</code>: Sets up a TEAM-engine instance (TE_BASE) 
      with the test suites listed in a CSV file.</li>
    </ul>
    </td>
  </tr>
</table>

To setup a TEAM-engine instance, unpack the archive created by the build process and 
just run the `setup-tebase` script for your environment. In order to run the script 
Maven and Git must be installed and available on the system path. Several environment 
variables must be set first (this can be done in the `setenv` script if desired):

* `TE_BASE`: A file system path that refers to the TEAM-engine instance directory.
* `ETS_SRC`: A file system path that refers to a directory containing the Git repositories; 
  (a repository will be cloned into here if it doesn't already exist).
* `JAVA_HOME`: Refers to a JDK installation directory.

A CSV file that lists the test suite releases of interest must be given as a script argument:

    $ ./setup-tebase ../../ctl-scripts-release.csv

The OGC test suites currently included in this package are listed in the [CSV file](src/main/config/ctl-scripts-release.csv).

Note that when building the [teamengine-web application](https://github.com/opengeospatial/teamengine), 
if the 'ogc.cite' profile is active then all test suite dependencies from ets-resources are 
incorporated within the WAR file. Otherwise the contents of the lib/ directory must be 
copied to the application classpath (WEB-INF/lib). 

The 'ets-resources-version' property can be set in ${user.home}/.m2/settings.xml as shown below, 
where `YY.MM.DD` denotes the desired release version.

    <profile>
      <id>ogc.cite</id>
      <!-- Activate by default or only when desired using the -P option
      <activation>
        <activeByDefault>true</activeByDefault>
      </activation>
      -->
      <properties>
        <ets-resources-version>YY.MM.DD</ets-resources-version>
      </properties>
    </profile>

Alternatively, the property can simply be specified as a command-line option:

    $ mvn package -P ogc.cite -Dets-resources-version=YY.MM.DD

