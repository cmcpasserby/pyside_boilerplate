#requires -Version 3

param(
    $Command
)

switch ($Command) {
    clean {
        Remove-Item build -Recurse -ErrorAction Ignore
        Remove-Item dist -Recurse -ErrorAction Ignore
        Remove-Item venv\pyinstaller -Recurse -ErrorAction Ignore
        # TODO: print info
    }

    devenv {
        virtualenv --clear --python=python3.9.5 venv/dev
        .\venv\dev\Scripts\activate.ps1
        pip install -r requirements\app.txt
        deactivate
        Write-Host "dev virtualenv made at venv/dev ('source venv/dev/bin/activate' to activate)"
    }

    ico {
        virtualenv --clear --python=python3.9.5 build\icoenv
        .\build\icoenv\Scripts\activate.ps1
        pip install -r requirements\ico.txt
        python scripts\build_ico.py
        deactivate
        # TODO: print info
    }

    pyinstaller {
        virtualenv --clear --python=python3.9.5 venv\pyinstaller
        .\venv\pyinstaller\Scripts\activate.ps1
        pip install -r requirements\pyinstaller.txt
        pip install -r requirements\app.txt
        pyinstaller -y misc\app_win.spec
        deactivate
        # TODO: print info
    }

    installer {
        # TODO: wix installer stuff
        $candle = Join-Path $env:WIX 'bin\candle.exe'
        $light = Join-Path $env:WIX 'bin\light.exe'
    }
}
