The charts are rendered with Google Charts (CoreChart): the loader is pulled from gstatic, google.charts.load('current', {packages:['corechart']}) runs, and drawCharts is invoked on load. 


Minute-level data is embedded directly as a JavaScript array (mdata) of [Date, Availability%, ResponseSeconds], which the chart function consumes. 



Two visualizations are placed into <div> containers—A) Minute-by-minute (month-to-date) at #m_chart and B) Hourly trend (month-to-date) at #h_chart. 



Above the graphs, a KPI cards grid summarizes Overall Availability, Total Downtime, Incidents, and Avg Response. 



The report includes a branded header (“CDP Monthly Uptime — September 2025”) with client/SLO/source/timestamp, plus a brand bar and legal footer for presentation.
