class CircularBuffer {
  final int _capacity;
  late int _size;
  late int _head;
  late int _tail;
  late List<double> _buffer;
  late double _average;

  CircularBuffer(this._capacity) {
    _size = 0;
    _head = 0;
    _tail = 0;
    _buffer = List<double>.filled(_capacity, 0);
  }

  void write(final double value) {
    if (_size == _capacity) {
      // If buffer is full, overwrite the oldest value
      _buffer[_head] = value;
      _head = (_head + 1) % _capacity;
    } else {
      // If buffer is not full, add value to the end
      _buffer[_tail] = value;
      _tail = (_tail + 1) % _capacity;
      ++_size;
    }
  }

  bool full() {
    return (_size == _capacity);
  }

  int size() {
    return _size;
  }

  int capacity() {
    return _capacity;
  }

  double average() {
    double result = 0.0;
     for (int i = 0; i < _size; i++) {
      result += get(i);
    }
    return result/_size;
  }

  double get(int index) {
  // Access element at a given index
    return _buffer[(_head + index) % _capacity];
  }


}




/*
#include <iostream>
#include <vector>

template<typename T>
class CircularBuffer {
public:
    CircularBuffer(int capacity)
        : m_capacity(capacity), m_size(0), m_head(0), m_tail(0), m_buffer(capacity) {}

    void push_back(const T& value) {
        if (m_size == m_capacity) {
            // If buffer is full, overwrite the oldest value
            m_buffer[m_head] = value;
            m_head = (m_head + 1) % m_capacity;
        } else {
            // If buffer is not full, add value to the end
            m_buffer[m_tail] = value;
            m_tail = (m_tail + 1) % m_capacity;
            ++m_size;
        }
    }

    T& operator[](int index) {
        // Access element at a given index
        return m_buffer[(m_head + index) % m_capacity];
    }

    int size() const {
        return m_size;
    }

    int capacity() const {
        return m_capacity;
    }

private:
    int m_capacity;
    int m_size;
    int m_head;
    int m_tail;
    std::vector<T> m_buffer;
};

 */