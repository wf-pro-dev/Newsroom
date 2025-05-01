# extensions.py
from flask_wtf.csrf import CSRFProtect

csrf = CSRFProtect()  # Create unbound CSRF instance
