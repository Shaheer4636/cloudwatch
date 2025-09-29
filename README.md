# Release Notes
| Version | Date       | Description |
| ------- | ---------- | ----------- |
| 1.0.1   | 06/22/2021 | Fix issues with security groups. Add VPC CIDR block to allow connectors. |
| 1.1.0   | 07/08/2021 | Allow VPN CIDR blocks access to Amazon MQ endpoints (usually port 5671). |
| 1.2.0   | 01/04/2022 | Added alarms and dashboard in Terraform code. Removed CIDR blocks that should not be allowed access in production by default. Updated README. |
| 2.0.0   | 03/10/2022 | Changed broker names to include random suffix string. Fixed bug with password being overwritten with multiple deployments to same AWS account. |
| 2.1.0   | 04/21/2022 | Added outputs for RMQ endpoints. |
| 2.2.0   | 05/27/2022 | Updated the Amazon MQ version to 1.0.0. |
| 2.3.0   | 08/08/2022 | Allowed Amazon MQ brokers to be named `<samc:APP_CLIENT>-<samc:APP_NAME>-<samc:APP_ENV>` to support SaaS Now project. Fixed dashboards. |
| 2.4.0   | 09/06/2022 | CIS_2_8 Enable KMS key rotation by default. |
| 2.5.0   | 02/14/2023 | Removed option to variablize access publicly, now internal only. |
| 2.5.1   | 03/01/2023 | Fixed reference to undefined `publicly_accessible` variable. |
| 2.6.0   | 03/08/2023 | Deprecated. Do **not** use. |
| 2.6.1   | 04/06/2023 | Downgraded parent to 1.0.0 locally. Adds support for CLUSTER_MULTI_AZ for RabbitMQ. Fixes tagging. Narrows access to port 5671. |
| 2.6.2   | 04/17/2023 | Fixed access to RabbitMQ web console on port 443. |
| 2.7.0   | 05/25/2023 | Creating a Security group with 61617 and 8162 ports whenever `engine` is "ActiveMQ". |
| 2.8.0   | 06/01/2023 | Allow for setting custom SNS topic name to associate with CloudWatch alarm actions. |
| 2.8.1   | 06/09/2023 | Fixed RabbitMQ dashboard for Multi-AZ and Single AZ – empty widgets. |
| 2.9.0   | 06/14/2023 | Enable general log by default for RabbitMQ. |
| 2.9.1   | 08/29/2023 | Fixed RabbitMQ alarms that were always in an insufficient data state when deployed in `CLUSTER_MULTI_AZ` mode. |
| 3.0.0   | 06/05/2024 | Added dependency on alarm-aggregator module. |
| 4.0.0   | 07/03/2024 | Requires the setting of three notification SNS topics for alarm levels: critical, high & medium. |
| 4.1.0   | 09/24/2024 | Added medium CloudWatch alerts for RabbitMQ. |
| 4.2.0   | 02/07/2025 | Added alarms and dashboard for ActiveMQ. |
| 4.2.1   | 08/18/2025 | Added support for environment-specific override of `queue_depth_alarm_period` via .tfvars files (e.g., `vars/idev.tfvars`). |
| 4.3.0   | 09/05/2025 | Minor enhancement: improved environment override handling and updated documentation for queue depth alarms. |
