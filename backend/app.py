from flask import Flask, request, jsonify, send_from_directory
import psycopg2
import os

app = Flask(__name__)


def get_db_connection():
    return psycopg2.connect(
        host=os.getenv("DB_HOST", "localhost"),
        database=os.getenv("DB_NAME", "feedbackdb"),
        user=os.getenv("DB_USER", "postgres"),
        password=os.getenv("DB_PASSWORD", "postgres"),
        port=os.getenv("DB_PORT", "5432"),
    )


@app.route("/")
def home():
    return send_from_directory("../frontend", "index.html")


@app.route("/feedback")
def feedback_page():
    return send_from_directory("../frontend", "feedback.html")


@app.route("/api/feedback", methods=["POST"])
def submit_feedback():
    data = request.get_json()

    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute(
        """
        INSERT INTO feedback (
            recruiter_name,
            designation,
            company_name,
            overall_rating,
            devops_skills,
            documentation,
            production_thinking,
            next_round,
            comments
        )
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """,
        (
            data["recruiter_name"],
            data["designation"],
            data["company_name"],
            data["overall_rating"],
            data["devops_skills"],
            data["documentation"],
            data["production_thinking"],
            data["next_round"],
            data.get("comments", ""),
        ),
    )

    conn.commit()
    cur.close()
    conn.close()

    return jsonify({"message": "Thank you for your feedback!"}), 201


@app.route("/api/feedback", methods=["GET"])
def get_feedback():
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute(
        """
        SELECT
            id,
            recruiter_name,
            designation,
            company_name,
            overall_rating,
            devops_skills,
            documentation,
            production_thinking,
            next_round,
            comments,
            created_at
        FROM feedback
        ORDER BY created_at DESC
        """
    )

    rows = cur.fetchall()

    cur.close()
    conn.close()

    feedback_list = []

    for row in rows:
        feedback_list.append(
            {
                "id": row[0],
                "recruiter_name": row[1],
                "designation": row[2],
                "company_name": row[3],
                "overall_rating": row[4],
                "devops_skills": row[5],
                "documentation": row[6],
                "production_thinking": row[7],
                "next_round": row[8],
                "comments": row[9],
                "created_at": row[10].strftime("%Y-%m-%d %H:%M:%S"),
            }
        )

    return jsonify(feedback_list), 200


@app.route("/health")
def health():
    return jsonify({"status": "healthy"}), 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
