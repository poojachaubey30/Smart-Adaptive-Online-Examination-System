
<%@ page import="java.util.List" %>
<%@ page import="model.Question" %>

<%!
    // Display HTML tags as normal text
    public String escapeHTML(String text) {
        if (text == null) {
            return "";
        }

        return text.replace("&", "&amp;")
                   .replace("<", "&lt;")
                   .replace(">", "&gt;")
                   .replace("\"", "&quot;")
                   .replace("'", "&#39;");
    }
%>

<%
    List<Question> questionList =
            (List<Question>) request.getAttribute("questionList");

    Integer examId =
            (Integer) request.getAttribute("examId");

    if (examId == null) {
        String id = request.getParameter("examId");
        if (id != null) {
            try {
                examId = Integer.parseInt(id);
            } catch (NumberFormatException e) {
                examId = 0;
            }
        }
    }

    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Start Examination</title>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 20px;
            font-family: Arial, sans-serif;
            background: #f4f6fb;
            color: #222;
        }

        .main-container {
            max-width: 1000px;
            margin: auto;
        }

        h1 {
            text-align: center;
            color: #172554;
        }

        .proctoring-box {
            background: white;
            border: 1px solid #d5dbea;
            border-radius: 10px;
            padding: 18px;
            margin-bottom: 20px;
            box-shadow: 0 2px 7px rgba(0,0,0,0.06);
        }

        .proctoring-box h2 {
            margin-top: 0;
            color: #172554;
            font-size: 20px;
        }

        .switch-count {
            font-size: 25px;
            font-weight: bold;
            color: #dc2626;
        }

        .warning {
            color: #dc2626;
            font-weight: bold;
            margin-top: 10px;
        }

        .camera-buttons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin: 12px 0;
        }

        button {
            border: none;
            padding: 11px 20px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
        }

        .start-btn {
            background: #15803d;
            color: white;
        }

        .stop-btn {
            background: #dc2626;
            color: white;
        }

        .submit-btn {
            background: #1d4ed8;
            color: white;
            padding: 13px 30px;
            margin-top: 20px;
        }

        button:hover {
            opacity: 0.85;
        }

        #cameraPreview {
            width: 280px;
            max-width: 100%;
            height: 190px;
            background: #111827;
            border-radius: 8px;
            display: block;
            margin-top: 12px;
            object-fit: cover;
        }

        .camera-status {
            font-weight: bold;
            margin-top: 10px;
        }

        .question-box {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 16px;
            box-shadow: 0 2px 7px rgba(0,0,0,0.06);
        }

        .question-title {
            font-weight: bold;
            font-size: 17px;
            margin-bottom: 15px;
        }

        .option {
            display: block;
            padding: 9px;
            margin: 5px 0;
            background: #f8fafc;
            border-radius: 5px;
            cursor: pointer;
        }

        .option input {
            margin-right: 8px;
        }

        .submit-container {
            text-align: center;
            margin-bottom: 30px;
        }

        @media(max-width: 600px) {
            body {
                padding: 10px;
            }

            .question-box,
            .proctoring-box {
                padding: 14px;
            }
        }
    </style>
</head>

<body>

<div class="main-container">

    <h1>Online Examination</h1>

    <!-- TAB MONITORING -->
    <div class="proctoring-box">

        <h2>AI Proctoring - Tab Monitoring</h2>

        <p>
            Tab Switch Count:
            <span class="switch-count" id="switchCount">00</span>
        </p>

        <p id="tabMessage">
            Please stay on the examination tab.
        </p>

    </div>


    <!-- CAMERA MONITORING -->
    <div class="proctoring-box">

        <h2>AI Proctoring - Camera Monitoring</h2>

        <p>
            Camera Status:
            <span class="camera-status" id="cameraStatus">
                Not Started
            </span>
        </p>

        <div class="camera-buttons">

            <button type="button"
                    class="start-btn"
                    id="startCameraBtn"
                    onclick="startCamera()">
                Start Camera
            </button>

            <button type="button"
                    class="stop-btn"
                    id="stopCameraBtn"
                    onclick="stopCamera()">
                Stop Camera
            </button>

        </div>

        <video id="cameraPreview"
               autoplay
               muted
               playsinline>
        </video>

        <p id="cameraMessage"></p>

    </div>


    <!-- EXAM QUESTIONS -->
    <form id="examForm"
          action="<%= contextPath %>/SubmitExamServlet"
          method="post">

        <input type="hidden"
               name="examId"
               value="<%= examId %>">

        <input type="hidden"
               name="tabSwitchCount"
               id="tabSwitchCount"
               value="0">

        <%
            if (questionList != null && !questionList.isEmpty()) {

                int questionNumber = 1;

                for (Question q : questionList) {
        %>

        <div class="question-box">

            <div class="question-title">
                Q<%= questionNumber %>.
                <%= escapeHTML(q.getQuestion()) %>
            </div>

            <label class="option">
                <input type="radio"
                       name="answer_<%= q.getQuestionId() %>"
                       value="A">
                <%= escapeHTML(q.getOptionA()) %>
            </label>

            <label class="option">
                <input type="radio"
                       name="answer_<%= q.getQuestionId() %>"
                       value="B">
                <%= escapeHTML(q.getOptionB()) %>
            </label>

            <label class="option">
                <input type="radio"
                       name="answer_<%= q.getQuestionId() %>"
                       value="C">
                <%= escapeHTML(q.getOptionC()) %>
            </label>

            <label class="option">
                <input type="radio"
                       name="answer_<%= q.getQuestionId() %>"
                       value="D">
                <%= escapeHTML(q.getOptionD()) %>
            </label>

        </div>

        <%
                    questionNumber++;
                }

            } else {
        %>

        <div class="question-box">
            <p>No questions available for this exam.</p>
        </div>

        <%
            }
        %>

        <div class="submit-container">

            <button type="submit"
                    class="submit-btn"
                    id="submitExamBtn">
                Submit Exam
            </button>

        </div>

    </form>

</div>


<script>

    // Exam details
    const examIdForLog = "<%= examId %>";
    const contextPath = "<%= contextPath %>";

    let switchCount = 0;
    let cameraStream = null;
    let examFinished = false;

    const switchCountElement =
        document.getElementById("switchCount");

    const hiddenCountInput =
        document.getElementById("tabSwitchCount");

    const tabMessage =
        document.getElementById("tabMessage");

    const video =
        document.getElementById("cameraPreview");

    const cameraStatus =
        document.getElementById("cameraStatus");

    const cameraMessage =
        document.getElementById("cameraMessage");


    // SAVE PROCTORING EVENT IN ORACLE
    function logProctoringEvent(eventType, eventDetails) {

        if (!examIdForLog || examIdForLog === "0") {
            console.error("Exam ID missing. Event not saved.");
            return;
        }

        const params = new URLSearchParams();

        params.append("examId", examIdForLog);
        params.append("eventType", eventType);
        params.append("eventDetails", eventDetails);

        fetch(contextPath + "/ProctoringLogServlet", {
            method: "POST",
            credentials: "same-origin",
            headers: {
                "Content-Type":
                    "application/x-www-form-urlencoded"
            },
            body: params.toString()
        })

        .then(response => {
            if (!response.ok) {
                throw new Error("HTTP Error: " + response.status);
            }

            return response.text();
        })

        .then(data => {
            console.log("Proctoring event saved:", data);
        })

        .catch(error => {
            console.error("Proctoring log error:", error);
        });
    }


    // TAB SWITCH DETECTION
    document.addEventListener("visibilitychange", function() {

        if (document.hidden && !examFinished) {

            switchCount++;

            switchCountElement.textContent =
                String(switchCount).padStart(2, "0");

            hiddenCountInput.value = switchCount;

            tabMessage.textContent =
                "Warning! You switched away from the examination tab.";

            tabMessage.classList.add("warning");

            logProctoringEvent(
                "TAB_SWITCH",
                "Exam tab hidden. Switch count: " + switchCount
            );
        }
    });


    // START CAMERA
    async function startCamera() {

        if (cameraStream) {
            cameraMessage.textContent = "Camera is already running.";
            return;
        }

        try {

            cameraStream =
                await navigator.mediaDevices.getUserMedia({
                    video: true,
                    audio: false
                });

            video.srcObject = cameraStream;

            cameraStatus.textContent = "Active";
            cameraStatus.style.color = "#15803d";

            cameraMessage.textContent =
                "Camera monitoring is active.";

            logProctoringEvent(
                "CAMERA_STARTED",
                "Camera preview started successfully."
            );

            const videoTrack =
                cameraStream.getVideoTracks()[0];

            if (videoTrack) {
                videoTrack.addEventListener("ended", function() {

                    if (cameraStream) {
                        cameraStream = null;
                        cameraStopped(
                            "Camera was stopped or disconnected."
                        );

                        logProctoringEvent(
                            "CAMERA_STOPPED",
                            "Camera track ended unexpectedly."
                        );
                    }

                });
            }

        } catch (error) {

            cameraStream = null;

            cameraStatus.textContent = "Permission Denied";
            cameraStatus.style.color = "#dc2626";

            cameraMessage.textContent =
                "Camera permission could not be granted.";

            logProctoringEvent(
                "CAMERA_PERMISSION_DENIED",
                "Camera permission denied or unavailable: " +
                error.message
            );

            console.error("Camera error:", error);
        }
    }


    // STOP CAMERA
    function stopCamera() {

        if (!cameraStream) {

            cameraMessage.textContent =
                "Camera is not currently running.";

            return;
        }

        cameraStream.getTracks().forEach(function(track) {
            track.stop();
        });

        cameraStream = null;

        cameraStopped(
            "Camera preview stopped by the user."
        );

        logProctoringEvent(
            "CAMERA_STOPPED",
            "Camera preview stopped by the user."
        );
    }


    // CAMERA STOPPED STATUS
    function cameraStopped(message) {

        video.srcObject = null;

        cameraStatus.textContent = "Stopped";
        cameraStatus.style.color = "#dc2626";

        cameraMessage.textContent = message;
        cameraMessage.classList.add("warning");
    }


    // EXAM SUBMISSION
    document.getElementById("examForm")
        .addEventListener("submit", function() {

            examFinished = true;

            if (cameraStream) {

                cameraStream.getTracks().forEach(function(track) {
                    track.stop();
                });

                cameraStream = null;
                video.srcObject = null;
            }

        });


    // RELEASE CAMERA WHEN LEAVING PAGE
    window.addEventListener("pagehide", function() {

        if (cameraStream) {

            cameraStream.getTracks().forEach(function(track) {
                track.stop();
            });

            cameraStream = null;
        }

    });

</script>

</body>
</html>
