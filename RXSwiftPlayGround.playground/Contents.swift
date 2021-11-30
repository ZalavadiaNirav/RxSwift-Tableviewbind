
import RxSwift
import RxCocoa
import UIKit

    //map

    Observable.of(1,2,3).map{ $0 + $0 }.subscribe(onNext: {
        print("MAP Result = \($0)")
    }).dispose()


    //flatMap and flatMapLatest

    struct Player
    {
        var score: BehaviorRelay<Int>
    }

    let disposeBag = DisposeBag()
    let stuart = Player(score: BehaviorRelay(value: 40))
    var alex = Player(score: BehaviorRelay(value: 50))
    let graham = Player(score: BehaviorRelay(value: 20))


    //FlatMap return all the values

    var currentPlayer = BehaviorRelay(value: alex)
    currentPlayer.asObservable().flatMap { $0.score.asObservable() }
    .subscribe(onNext: {
        print("Flat Map = \($0)")
    }).disposed(by: disposeBag)

    //accept is used to modify value of BehaviorRelay
    currentPlayer.value.score.accept(120)
    stuart.score.accept(100)


    //FlatMapLatest Only Return latest Value
    var currentPlayer1 = BehaviorRelay(value: graham)
    currentPlayer1.asObservable().flatMapLatest { $0.score.asObservable() }
    .subscribe(onNext: {
        print("Flat Map Latest = \($0)")
    }).disposed(by: disposeBag)


    currentPlayer1.value.score.accept(120)
    stuart.score.accept(100)

    //Score
    let disposeBag2 = DisposeBag()
    let dartScrore = PublishSubject<Int>()
    dartScrore
        .scan(500, accumulator: -)
        .map { max($0,0) }
        .subscribe(onNext: {
            print("Score = \($0)")
        }).disposed(by: disposeBag2)
    dartScrore.onNext(40)
    dartScrore.onNext(50)

//Buffer
let disposeBag3 = DisposeBag()
let dartScrore2 = PublishSubject<Int>()
dartScrore2
    .buffer(timeSpan:DispatchTimeInterval.seconds(3), count: 3, scheduler: MainScheduler.instance)
    .map {
        print($0,"=> ",terminator: "")
        return $0.reduce(0,+)
    }
    .scan(500, accumulator: -)
    .map { max($0,0) }
    .subscribe(onNext: {
        print("Buffer = \($0)")
    }).disposed(by: disposeBag3)
    dartScrore2.onNext(40)
    dartScrore2.onNext(50)
    dartScrore2.onNext(30)


