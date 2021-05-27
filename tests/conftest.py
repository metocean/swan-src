# config to run pytest tests
import pytest

def pytest_addoption(parser):
    parser.addoption(
        "--models", action="store", default="4091,4120", help="model versions to be compared (ref,new => i.e. comma separated)"
    )
    parser.addoption(
        "--imp", action="store", default="tinyapp", help="implementation to be tested"
    )
    parser.addoption(
        "--ncores", action="store", default="2", help="number of cores to be tested"
    )

@pytest.fixture
def models(request):
    return request.config.getoption("--models").split(',')

@pytest.fixture
def imp(request):
    return request.config.getoption("--imp")

@pytest.fixture
def ncores(request):
    return request.config.getoption("--ncores") 