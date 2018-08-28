# config to run pytest tests
import pytest

def pytest_addoption(parser):
    parser.addoption(
        "--models", action="store", default="4091,4120", help="model versions to be compared (ref,new => i.e. comma separated)"
    )

@pytest.fixture
def models(request):
    return request.config.getoption("--models").split(',')