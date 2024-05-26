from typing import Dict, Optional, Type, List
from .client import Client
__all__ = ['Client', 'EtcdError', 'EtcdException', 'EtcdEventIndexCleared', 'EtcdWatcherCleared', 'EtcdKeyNotFound', 'EtcdAlreadyExist', 'EtcdResult', 'EtcdConnectionFailed', 'EtcdWatchTimedOut']
class EtcdResult:
    action: str = ...
    modifiedIndex: int = ...
    key: str = ...
    value: str = ...
    ttl: Optional[float] = ...
    @property
    def leaves(self) -> List['EtcdResult']: ...
class EtcdException(Exception):
    def __init__(self, message=..., payload=...) -> None: ...
class EtcdConnectionFailed(EtcdException):
    def __init__(self, message=..., payload=..., cause=...) -> None: ...
class EtcdKeyError(EtcdException): ...
class EtcdKeyNotFound(EtcdKeyError): ...
class EtcdAlreadyExist(EtcdKeyError): ...
class EtcdEventIndexCleared(EtcdException): ...
class EtcdWatchTimedOut(EtcdConnectionFailed): ...
class EtcdWatcherCleared(EtcdException): ...
class EtcdLeaderElectionInProgress(EtcdException): ...
class EtcdError:
    error_exceptions: Dict[int, Type[EtcdException]] = ...
