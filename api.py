import typing



def request(method: str, 
            url: str, 
            headers: typing.Sequence[typing.Tuple[bytes, bytes]] = (),
            body: typing.Union[bytes, typing.AsyncIterator[bytes]] = b"",
            stream: bool = False,
            ) -> "Response":
            return Response(200, body=b"Hello, world!")

        


class Response:

    def __init__(self, status_code: int, 
                    headers: typing.Sequence[typing.Tuple[bytes, bytes]] = (),
                    body: typing.Union[bytes, typing.AsyncIterator[bytes]] = b"",
                    on_close: typing.Callable = None
                    ):
        self.status_code = status_code
        self.headers = list(headers)
        if isinstance(body, bytes):
            self.body = body
        else:
            self.body_aiter = body

    def read(self) -> bytes:
        if not hasattr(self, "body"):
            body = b""
        return self.body