from fastapi import APIRouter

router = APIRouter()

@router.get("/routes")
def get_routes():
    return {
        "routes": []
    }