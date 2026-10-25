
## 2024-10-24 - Lazy evaluation for log messages
**Learning:** WhatsApp creates a massive number of log messages at errorLevel 1 and 2, and previously the interception code executed computationally expensive string array mapping and string concatenation (makeLogMessage) for every log frame before determining it should be dropped.
**Action:** Compute log messages lazily. Only perform string parsing and joining after verifying that the debugMode is on or the log level requires execution.
