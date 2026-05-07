from sqlalchemy.orm import declarative_base
from sqlalchemy import Column, Integer, String

Base = declarative_base()

class IPv6Route(Base):
    __tablename__ = "ipv6_routes"

    id = Column(Integer, primary_key=True)

    prefix = Column(
        String,
        unique=True,
        nullable=False
    )

    collector = Column(String)