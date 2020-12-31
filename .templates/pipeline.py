import conducto as co


def main() -> co.Serial:
    with co.Serial() as node:
        node["hello"] = co.Exec("echo hi")
    return node


if __name__ == "__main__":
    co.main(default=main)
