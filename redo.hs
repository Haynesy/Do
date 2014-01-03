import System.Environment (getArgs)
import System.Process (createProcess, shell, waitForProcess)
-- import qualified

main :: IO ()
main = do
    args <- getArgs
    mapM_ redo args
    return ()
    
    
redo :: String -> IO ()
redo target = do
    (_, _, _, ph) <- createProcess $ shell $ "sh " ++ target ++ ".do"
    _ <- waitForProcess ph
    return ()

