import os

from authlib.integrations.flask_client import OAuth
from dotenv import load_dotenv
from flask import Flask, redirect, session, url_for

load_dotenv()

app = Flask(__name__)
app.secret_key = os.urandom(24)

oauth = OAuth(app)
oauth.register(
    name="microsoft",
    client_id=os.getenv("CLIENT_ID"),
    client_secret=os.getenv("CLIENT_SECRET"),
    server_metadata_url=(
        f"https://login.microsoftonline.com/{os.getenv('TENANT_ID')}/v2.0/.well-known/openid-configuration"
    ),
    client_kwargs={"scope": "openid profile email User.Read"},
)


@app.route("/")
def index():
    user = session.get("user")
    if not user:
        return '<h2>M159 SSO Demo</h2><a href="/login">Login mit Microsoft</a>'
    return (
        f"<h2>Eingeloggt</h2>"
        f"<p>Name: {user.get('name')}</p>"
        f"<p>UPN: {user.get('preferred_username')}</p>"
        f'<a href="/logout">Logout</a>'
    )


@app.route("/login")
def login():
    redirect_uri = url_for("auth", _external=True)
    return oauth.microsoft.authorize_redirect(redirect_uri)


@app.route("/getAToken")
def auth():
    token = oauth.microsoft.authorize_access_token()
    session["user"] = token.get("userinfo")
    return redirect("/")


@app.route("/logout")
def logout():
    session.clear()
    return redirect("/")


if __name__ == "__main__":
    app.run(port=5000)
