import System.Directory (renameFile, removeFile)
import System.Environment (getArgs)
import System.Exit (ExitCode(..))
import System.IO (hPutStrLn, stderr)
import System.Process (
        createProcess, 
        shell, 
        waitForProcess)
-- import qualified System.Process as SP

main :: IO ()
main = do
    args <- getArgs
    mapM_ redo args
    return ()
    
redo :: String -> IO ()
redo target = do
    let tmp = target ++ "---redoing"
    (_, _, _, ph) <- createProcess $ shell $ "sh " ++ target ++ ".do > "++ tmp ++ " > " ++ tmp
    exit <- waitForProcess ph
    case exit of
        ExitSuccess -> renameFile tmp target
        ExitFailure code -> do 
            hPutStrLn stderr $ "Redo script exited with non-standard exit code: " ++ show code 
            removeFile tmp
