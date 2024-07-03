# ADD TABLE TO DB:
    flask db init
    flask db migrate -m "Initial migration"
    flask db upgrade

# IF ERROR: Remove "migrations" folder and:
- Drop table alembic_version
- Add table user
- Add table token_blacklist