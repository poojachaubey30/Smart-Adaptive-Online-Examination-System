```jsp
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AI Proctoring Monitor</title>

    <style>
        * {
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            margin: 0;
            padding: 30px;
            background: #f1f5f9;
            color: #1e293b;
        }

        .container {
            max-width: 700px;
            margin: 30px auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        h1 {
            text-align: center;
            color: #1d4ed8;
        }

        .status {
            padding: 15px;
            background: #dcfce7;
            color: #166534;
            border-radius: 8px;
            margin: 20px 0;
        }

        .count {
            font-size: 22px;
            font-weight: bold;
        }

        .warning {
            color: #dc2626;
            font-weight: bold;
            min-height: 24px;
        }

        button {
            display: block;
            margin: 25px auto 0;
            padding: 12px 25px;
            border: none;
            border-radius: 7px;
            background: #1d4ed8;
            color: white;
            cursor: pointer;
            font-size: 16px;
        }
    </style>
</head>

<body>
<div class="container">

    <h1>AI Proctoring Monitor</h1>

    <p>
        This monitor detects when you switch away from the examination tab.
    </p>

    <div class="status" id="statusBox">
        Monitoring is active.
    </div>

    <p>
        Total tab switches:
        <span class="count" id="switchCount">0</span>
    </p>

    <p class="warning" id="warningMessage"></p>

    <button type="button" onclick="resetMonitor()">
        Reset Counter
    </button>

</div>

<script>
    let tabSwitches = 0;

    document.addEventListener("visibilitychange", function () {

        if (document.hidden) {
            tabSwitches++;

            document.getElementById("switchCount").textContent =
                tabSwitches;

            document.getElementById("warningMessage").textContent =
                "Warning! Do not switch away from the examination tab.";

            document.getElementById("statusBox").textContent =
                "Tab switching detected!";

            document.getElementById("statusBox").style.background =
                "#fee2e2";

            document.getElementById("statusBox").style.color =
                "#991b1b";
        } else {
            if (tabSwitches > 0) {
                document.getElementById("warningMessage").textContent =
                    "Warning count: " + tabSwitches +
                    ". Please stay on the exam tab.";
            }
        }
    });

    function resetMonitor() {
        tabSwitches = 0;

        document.getElementById("switchCount").textContent = "0";
        document.getElementById("warningMessage").textContent = "";
        document.getElementById("statusBox").textContent =
            "Monitoring is active.";

        document.getElementById("statusBox").style.background =
            "#dcfce7";

        document.getElementById("statusBox").style.color =
            "#166534";
    }
</script>

</body>
</html>
```